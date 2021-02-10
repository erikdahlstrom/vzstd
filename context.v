module vzstd

#flag -D ZSTD_STATIC_LINKING_ONLY
#flag -I @VROOT/zstd/lib
#include "zstd.h"

[ref_only]
struct C.ZSTD_CCtx {
}

fn C.ZSTD_createCCtx() &ZSTD_CCtx

fn C.ZSTD_freeCCtx(cctx &ZSTD_CCtx) size_t

fn C.ZSTD_compressCCtx(cctx &ZSTD_CCtx, dst voidptr, dstCapacity size_t, src voidptr, srcSize size_t, compressionLevel int) size_t

[ref_only]
struct C.ZSTD_DCtx {}

fn C.ZSTD_createDCtx() &ZSTD_DCtx

fn C.ZSTD_freeDCtx(dctx &ZSTD_DCtx) size_t

fn C.ZSTD_decompressDCtx(dctx &ZSTD_DCtx, dst voidptr, dstCapacity size_t, src voidptr, srcSize size_t) size_t

// Compression
pub struct CompressionContext {
	cctx &C.ZSTD_CCtx = 0
}

pub fn create_compression_context() CompressionContext {
	mut cctx := CompressionContext{C.ZSTD_createCCtx()}
	return cctx
}

pub fn free_compression_context(ctx CompressionContext) size_t {
	return C.ZSTD_freeCCtx(ctx.cctx)
}

pub fn (ctx CompressionContext) compress(mut dst []byte, src []byte, compression_level int) size_t {
	result := C.ZSTD_compressCCtx(ctx.cctx, dst.data, dst.len, src.data, src.len, compression_level)
	if C.ZSTD_isError(result) != 0 {
		return result
	}
	new_len := int(result)
	dst = dst[..new_len]
	return result
}

// decompression

pub struct DecompressionContext {
	dctx &C.ZSTD_DCtx = 0
}

pub fn create_decompression_context() DecompressionContext {
	mut ctx := DecompressionContext{C.ZSTD_createDCtx()}
	return ctx
}

pub fn free_decompression_context(ctx DecompressionContext) size_t {
	return C.ZSTD_freeDCtx(ctx.dctx)
}

pub fn (ctx DecompressionContext) decompress(mut dst []byte, src []byte) size_t {
	result := C.ZSTD_decompressDCtx(ctx.dctx, dst.data, dst.len, src.data, src.len)
	if C.ZSTD_isError(result) != 0 {
		return result
	}
	new_len := int(result)
	dst = dst[..new_len]
	return result
}
