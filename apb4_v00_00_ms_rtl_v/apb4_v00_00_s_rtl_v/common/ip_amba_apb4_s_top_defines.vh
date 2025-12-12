/* -----------------------------------------------------------------------------------
 * Module Name  :
 * Date Created : 12:04:30 IST, 29 March, 2021 [ Monday ]
 *
 * Author       : pxvi
 * Description  :
 * -----------------------------------------------------------------------------------

   MIT License

   Copyright (c) 2020 k-sva

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the Software), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

 * ----------------------------------------------------------------------------------- */

`define APB4_SLV_PSTRB_WIDTH         4
`define APB4_SLV_PWDATA_WIDTH        8 * `APB4_SLV_PSTRB_WIDTH
`define APB4_SLV_PRDATA_WIDTH        32
`define APB4_SLV_PADDR_WIDTH         32
`define APB4_SLV_PSEL_WIDTH         1

// By default the Memory Depth is 2**MEM_ARRAY_SIZE_INT
`define APB4_SLV_MEM_ARRAY_SIZE_INT  2

// By Default the Declaration is in Bytes
`ifndef GB
    `ifndef MB
        `ifndef B
            `define B       1
        `else
            `define KB      1
        `endif
    `else
        `define MB          1
    `endif
`else
    `define GB              1
`endif

`define APB4_SLV_DEV_BASE_ADDRESS    32'h0
