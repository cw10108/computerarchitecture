#----------------------------------------------------------------
#
#  4190.308 Computer Architecture (Fall 2020)
#
#  Project #3: RISC-V Assembly Programming
#
#  October 26, 2020
#
#  Injae Kang (abcinje@snu.ac.kr)
#  Sunmin Jeong (sunnyday0208@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#----------------------------------------------------------------


	.data
	.align	2

	.globl	test
test:
	.word	test0
	.word	test1
	.word	test2
	.word	test3
	.word	test4
	.word	test5

	.globl	ans
ans:
	.word	ans0
	.word	ans1
	.word	ans2
	.word	ans3
	.word	ans4
	.word	ans5

test0:
	.word	0x0000002b
	.word	0x485f2067
	.word	0x1362a128
	.word	0x32343038
	.word	0x09459838
	.word	0x04307d24
	.word	0xc06c4c9b
	.word	0x892967f1
	.word	0x9a494120
	.word	0xd1312116
	.word	0xc5a4b383
	.word	0x007c0509
ans0:
	.word	0x0000002c
	.word	0x20656854
	.word	0x63697571
	.word	0x7262206b
	.word	0x206e776f
	.word	0x20786f66
	.word	0x706d756a
	.word	0x766f2073
	.word	0x74207265
	.word	0x6c206568
	.word	0x20797a61
	.word	0x2e676f64
test1:
	.word	0x0000000e
	.word	0x12af370b
	.word	0x9a3f2328
	.word	0x15f92189
	.word	0x00006c63
ans1:
	.word	0x0000000a
	.word	0x1aef05ab
	.word	0xb3d307fb
	.word	0x00008720

test2:
	.word	0x00000007
	.word	0x4513ac02
	.word	0x00208826
ans2:
	.word	0x00000003
	.word	0x002020ca


test3:
	.word	0x0000000e
	.word	0x57024e61
	.word	0xc1c6a065
	.word	0x08b83015
	.word	0x0000c062
ans3:
	.word	0x0000000a
	.word	0x616a6e49
	.word	0x614b2065
	.word	0x0000676e


test4:
	.word	0x00000008
	.word	0x12f0abed
	.word	0x40601132
ans4:
	.word	0x00000004
	.word	0xefbeadde
test5:
        .word   0x0000010f
        .word   0x98d032a4
        .word   0xa346ad2d
        .word   0x380727fd
        .word   0xe1fdefe5
        .word   0x6ae6d11c
        .word   0x7b7abe67
        .word   0xb7a76294
        .word   0xbb578ded
        .word   0x70cf39a7
        .word   0xb93452f4
        .word   0xcd7d632a
        .word   0x404c92ba
        .word   0xfc47abf8
        .word   0xd01bb2d6
        .word   0xfd4ee31b
        .word   0x77ce899b
        .word   0x7bd5586f
        .word   0x06c64254
        .word   0xfd7fd4c4
        .word   0xd6d668aa
        .word   0xe20dec3d
        .word   0xe35ccb8d
        .word   0x56f1e815
        .word   0xc871c373
        .word   0x4f781680
        .word   0x6b9ffba2
        .word   0x2f1a9575
        .word   0xef0191da
        .word   0xb855f3d7
        .word   0xaf3be4d9
        .word   0x38d49fe7
        .word   0xdcc1f192
        .word   0x748cb97f
        .word   0xdcab02c9
        .word   0x1973f4c2
        .word   0x4f752ed4
        .word   0x79f332f8
        .word   0xe359a0c3
        .word   0xfbc7f2aa
        .word   0x919b59af
        .word   0xd61db14b
        .word   0xe0aff7fa
        .word   0x7dfe8845
        .word   0x618e05ec
        .word   0xda2ab9d7
        .word   0xa6d6ebeb
        .word   0xf893cf3d
        .word   0x9ca8bebc
        .word   0xeb3c76c6
        .word   0x8cd4d49f
        .word   0xcee5d863
        .word   0x776bf8bb
        .word   0xb776eb3f
        .word   0x1e7cfcec
        .word   0x554ae37e
        .word   0x6fff5b8f
        .word   0xbf2f39d1
        .word   0x702cae12
        .word   0x334b2bd7
        .word   0x9a7bb374
        .word   0x7ee00258
        .word   0xb72b7769
        .word   0xb977cdd1
        .word   0x1df3ef35
        .word   0xd9e74cbe
        .word   0xcfb41503
        .word   0xfae83e7d
        .word   0x00c4e79d

ans5:
        .word   0x00000100
        .word   0xfc6d6d73
        .word   0xb8511444
        .word   0xb64acb7f
        .word   0xce00594b
        .word   0x4d032726
        .word   0xa6e7c890
        .word   0x5520c69e
        .word   0x344326c1
        .word   0xd730b093
        .word   0x449082c5
        .word   0x98fada4d
        .word   0x5a66fb34
        .word   0xb2a76a22
        .word   0xd0588e32
        .word   0x16267855
        .word   0x314a699e
        .word   0xdf097a1a
        .word   0x492399fc
        .word   0xa7e11e73
        .word   0x3b024819
        .word   0xe4eda9b2
        .word   0x8db44538
        .word   0x5ba3dabd
        .word   0x5e8ced44
        .word   0x643d9567
        .word   0xa2ad602e
        .word   0x97498f7e
        .word   0x89d24bd7
        .word   0x2d6dbff5
        .word   0xc1ba2104
        .word   0x401c5dfc
        .word   0xb19ea94a
        .word   0x6d15db3e
        .word   0xba0fc33b
        .word   0x29515852
        .word   0x99b224a4
        .word   0xe8c61fe3
        .word   0x3ca98040
        .word   0x277cc6dd
        .word   0xadd81a6f
        .word   0x311aeef5
        .word   0x03eb29b1
        .word   0x262c3c82
        .word   0x44bfde60
        .word   0x3d2c85fd
        .word   0xe27ad505
        .word   0x0a09f69b
        .word   0x06b8e111
        .word   0x8037d2cf
        .word   0x7e8322fc
        .word   0xbfa4af5f
        .word   0x8a03638d
        .word   0xedc82fe8
        .word   0xa0cf4205
        .word   0x49abd838
        .word   0x895063b9
        .word   0x31098735
        .word   0x09af8daa
        .word   0xcac8533c
        .word   0x9e54ccb6
        .word   0x008b1cfb
        .word   0x97a15a5e
        .word   0xece04c32
        .word   0xe47530af

