module vzstd

#flag -D ZSTD_STATIC_LINKING_ONLY
#flag -I @VROOT/zstd/lib
#flag @VROOT/zstd/lib/decompress/huf_decompress.o
#flag @VROOT/zstd/lib/decompress/zstd_ddict.o
#flag @VROOT/zstd/lib/decompress/zstd_decompress.o
#flag @VROOT/zstd/lib/decompress/zstd_decompress_block.o
#flag @VROOT/zstd/lib/compress/fse_compress.o
#flag @VROOT/zstd/lib/compress/zstd_double_fast.o
#flag @VROOT/zstd/lib/compress/hist.o
#flag @VROOT/zstd/lib/compress/huf_compress.o
#flag @VROOT/zstd/lib/compress/zstd_compress.o
#flag @VROOT/zstd/lib/compress/zstd_compress_literals.o
#flag @VROOT/zstd/lib/compress/zstd_compress_sequences.o
#flag @VROOT/zstd/lib/compress/zstd_compress_superblock.o
#flag @VROOT/zstd/lib/compress/zstd_fast.o
#flag @VROOT/zstd/lib/compress/zstd_lazy.o
#flag @VROOT/zstd/lib/compress/zstd_ldm.o
#flag @VROOT/zstd/lib/compress/zstd_opt.o
#flag @VROOT/zstd/lib/compress/zstdmt_compress.o
#include "zstd.h"

fn C.ZSTD_compress(voidptr, size_t, voidptr, size_t, int) size_t

fn C.ZSTD_getFrameContentSize(voidptr, size_t) u64

fn C.ZSTD_findFrameCompressedSize(src voidptr, srcSize size_t) size_t

fn C.ZSTD_compressBound(srcSize size_t) size_t

fn C.ZSTD_minCLevel() int

fn C.ZSTD_maxCLevel() int

pub fn compress(mut dst []byte, src []byte, compression_level int) size_t {
	result := C.ZSTD_compress(mut dst.data, dst.len, src.data, src.len, compression_level)
	if C.ZSTD_isError(result) != 0 {
		return result
	}
	new_len := int(result)
	dst = dst[..new_len]
	return result
}

pub fn get_frame_content_size(frame []byte) u64 {
	return C.ZSTD_getFrameContentSize(frame.data, frame.len)
}

pub fn find_frame_compressed_size(src []byte) size_t {
	return C.ZSTD_findFrameCompressedSize(src.data, src.len)
}

pub fn compress_bound(srcSize size_t) size_t {
	return C.ZSTD_compressBound(srcSize)
}

pub fn min_c_level() int {
	return C.ZSTD_minCLevel()
}

pub fn max_c_level() int {
	return C.ZSTD_maxCLevel()
}
