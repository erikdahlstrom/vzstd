module main
import vzstd

fn test_create_then_free_cctx() {
	ctx := vzstd.create_compression_context()
	res := vzstd.free_compression_context(ctx)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
}

fn test_create_then_free_dctx() {
	ctx := vzstd.create_decompression_context()
	res := vzstd.free_decompression_context(ctx)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
}

fn test_compress_with_context() {
	ctx := vzstd.create_compression_context()
	mut embed := $embed_file('context_test.v')
	inbytes := []byte{len: embed.len, init: embed.data()}
	assert inbytes.len > 0
	mut outbytes := []byte{len: 1500}
 	mut res := ctx.compress(mut outbytes, inbytes, 5)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
	assert inbytes.len > outbytes.len
	res = vzstd.free_compression_context(ctx)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
}

fn test_decompress_with_context() {
	// make some compressed data
	mut embed := $embed_file('context_test.v')
	uncompressed := []byte{len: embed.len, init: embed.data()}
	assert uncompressed.len > 0
	mut compressed := []byte{len: 1500}
 	mut res := vzstd.compress(mut compressed, uncompressed, 5)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
	assert compressed.len < uncompressed.len

	// here's the actual test
	ctx := vzstd.create_decompression_context()
	mut decompressed_data := []byte{len: uncompressed.len}
	res = ctx.decompress(mut decompressed_data, compressed)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
	assert decompressed_data.len == uncompressed.len
	assert decompressed_data == uncompressed
	res = vzstd.free_decompression_context(ctx)
	assert vzstd.get_error_name(res) == vzstd.get_error_name(size_t(0))
	assert vzstd.is_error(res) == false
}
