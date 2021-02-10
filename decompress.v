module vzstd

#flag -D ZSTD_STATIC_LINKING_ONLY
#flag -I @VROOT/zstd/lib
#flag @VROOT/zstd/lib/decompress/huf_decompress.o
#flag @VROOT/zstd/lib/decompress/zstd_ddict.o
#flag @VROOT/zstd/lib/decompress/zstd_decompress.o
#flag @VROOT/zstd/lib/decompress/zstd_decompress_block.o
#include "zstd.h"

fn C.ZSTD_decompress(voidptr, size_t, voidptr, size_t, int) size_t

pub fn decompress(mut dst []byte, src []byte) size_t {
	result := C.ZSTD_decompress(mut dst.data, dst.len, src.data, src.len)
	if C.ZSTD_isError(result) != 0 {
		return result
	}
	new_len := int(result)
	dst = dst[..new_len]
	return result
}
