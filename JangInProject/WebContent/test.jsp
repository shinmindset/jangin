

    <!DOCTYPE html> 

    <html> 

    <head> 

    <meta charset="UTF-8"> 

    <title>Insert title here</title> 

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> 

    <script type="text/javascript"> 

          $(document).ready(function(){ 

                 // 항목추가 버튼 클릭시 

                 $(".addBtn").click(function(){ 

                        var clickedRow = $(this).parent().parent(); 

                        var cls = clickedRow.attr("class"); 

                        // tr 복사해서 마지막에 추가 

                        var newrow = clickedRow.clone(); 

                        newrow.find("td:eq(0)").remove(); 

                        newrow.insertAfter($("#example ."+cls+":last")); 

                        // rowspan 증가 

                        resizeRowspan(cls); 

                 }); 

                   

                   

                 // 삭제버튼 클릭시 

                 $(".delBtn").live("click", function(){ 

                        var clickedRow = $(this).parent().parent(); 

                        var cls = clickedRow.attr("class"); 

                          

                        // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다. 

                        if( clickedRow.find("td:eq(0)").attr("rowspan") ){ 

                               if( clickedRow.next().hasClass(cls) ){ 

                                      clickedRow.next().prepend(clickedRow.find("td:eq(0)")); 

                               } 

                        } 

                        clickedRow.remove(); 

                        resizeRowspan(cls); 

                 }); 

                 // cls : rowspan 을 조정할 class ex) item1, item2, ... 

                 function resizeRowspan(cls){ 

                        var rowspan = $("."+cls).length; 

                        $("."+cls+":first td:eq(0)").attr("rowspan", rowspan); 

                 } 

          }); 

          function rem() { 

       $("#example tr:last").remove(); 

          } 

    </script> 

    </head> 

    <body> 

    <table id="example" border="1"> 

          <tr> 

              <th>Option Name</th> 

              <th>Item Name</th> 

              <th>Fundamental Item</th> 

              <th>Price</th> 

              <th>Unit</th> 

              <th>Additional Option</th> 

          </tr> 

          <tr class="item1"> 

              <td><input type="text" /><button class="addBtn">Item Add</button></td> 

              <td><input type="text" /></td> 

              <td><input type="checkbox" /></td> 

              <td><input type="text" /></td> 

              <td><input type="text" /></td> 

              <td><button class="delBtn">Delete</button></td> 

          </tr> 

          <tr class="item2"> 

              <td><input type="text" /><button class="addBtn">Item Add</button></td> 

              <td><input type="text" /></td> 

              <td><input type="checkbox" /></td> 

              <td><input type="text" /></td> 

              <td><input type="text" /></td> 

              <td><button class="delBtn">Delete</button></td> 

          </tr> 

          <tr class="item3"> 

              <td><input type="text" /><button class="addBtn">Item Add</button></td> 

              <td><input type="text" /></td> 

              <td><input type="checkbox" /></td> 

              <td><input type="text" /></td> 

              <td><input type="text" /></td> 

              <td><button class="delBtn">Delete</button></td> 

          </tr> 

          <tr class="item4"> 

              <td><input type="text" /><button class="addBtn">Item Add</button></td> 

              <td><input type="text" /></td> 

              <td><input type="checkbox" /></td> 

              <td><input type="text" /></td> 

              <td><input type="text" /></td> 

              <td><button class="delBtn">Delete</button></td> 

          </tr> 

    </table> 

    <div> 

    <input type="button" onclick="rem();" value="delete last row in the table" /> 

    </div> 

    </body> 

    </html> 

