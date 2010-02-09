import Vector::*; 

function Action printElement(function Action disp(), Tuple2#(Integer,data_t) entry)
  provisos(Bits#(data_t,data_t_size));
  action
    disp();
    $display("[%d]: %h",tpl_1(entry), tpl_2(entry));
  endaction
endfunction

function Action printVector(function Action disp(), Vector#(n,data_t) vector) 
  provisos(Bits#(data_t,data_t_size));
  action
    joinActions(map(printElement(disp), zip(genVector,vector)));
  endaction
endfunction