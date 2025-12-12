/* -----------------------------------------------------------------------------------
 * Module Name  :
 * Date Created : 10:53:39 IST, 29 March, 2021 [ Monday ]
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

// Design Attributes Parameters
// -----------------------------
`define APB4_MST_DESIGN_ATTRIBUTES #( \
                                            parameter PRDATA_width = `APB4_MST_PRDATA_WIDTH, \
                                            parameter PWDATA_width = `APB4_MST_PWDATA_WIDTH, \
                                            parameter PSTRB_width = `APB4_MST_PSTRB_WIDTH, \
                                            parameter PADDR_width = `APB4_MST_PADDR_WIDTH, \
                                            parameter PSELx_width = `APB4_MST_PSEL_WIDTH \
                                            )
