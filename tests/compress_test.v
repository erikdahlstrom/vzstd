module main

import vzstd
import os

fn test_simple_compress() {
	mut embed := $embed_file('compress_test.v')
	inbytes := []byte{len: embed.len, init: embed.data()}
	assert inbytes.len > 0
	mut outbytes := []byte{len: 1500}
 	res := vzstd.compress(mut outbytes, inbytes, 5)
	assert !vzstd.is_error(res)
	assert inbytes.len > outbytes.len
}
