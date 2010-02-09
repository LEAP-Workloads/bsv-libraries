import Complex::*;
import Vector::*;
import FixedPoint::*;
import FIFO::*;
import Real::*;


// This FFT interface has two parameters. The first 'points' controls
// (as you might imagine) the width (number of points) of the design.
// The fact that is a 'numeric' type, is a subtle issue relating to
// the different kinds of types present in the Bluespec language.  You
// can read more about numeric types in the reference manual.  The
// parameter 'data' controlls the type of data which will be
// transformed.  For example, the data type could be int, fixed point,
// complex, etc. depending on the intended use.  Through the use of
// Type Classes, the type parameters can be restricted, as can be seen
// in the definition of module mkFFT

interface FFT#(numeric type points, type data);
  method Action fftInput(Vector#(points, data) inVector);
  method ActionValue#(Vector#(points, data)) fftOutput;
endinterface



// mkFFT provides an implementation of the FFT interface.  As you can
// see the parameterization of this module definition is slightly more
// restricted than that of the interface definition, in that we are
// restricting the data parameter to be a Complex number.  Through the
// use of pattern matching, we are able to exactract the type
// parameter of Complex, and give it a name 'cmplxd'.  Provisos
// (indicated by the language keyword 'provisos') are used to restrcit
// the allowable types which can be used to parameterize this module.
// Provisos generally fall into two major categories, the first being
// to relate numeric types, and the second to assert that type
// parameters are members of certain Type Classes.  Go to
// \href{link}[link} for a good explaination of type classes and
// provisos.  Provisos can also be used to create new type variables.
// For example, the proviso Log#(points, log_points) is not not so
// much an assertion as the creation of a new variable log_points,
// which recieves the value log(points).  Arith#(cmplxd) asserts that
// the parameter cmplxd is a member of the Arith type Class.  Members
// of the Arith typeclass have arithmetic operations defined on them.
// For explaination of RealLiteral and Bits, see the language
// reference guide. 

module mkFFT (FFT#(points,Complex#(cmplxd)))
  provisos(Log#(points, log_points),
           Arith#(cmplxd),
           RealLiteral#(cmplxd),
           Bits#(cmplxd,cmplxd_sz));
           

  
  FIFO#(Vector#(points,Complex#(cmplxd))) inputFIFO <- mkFIFO; 
  FIFO#(Vector#(points,Complex#(cmplxd))) outputFIFO <- mkFIFO; 


  // compute the twiddle factor.  This function implements the math
  // described in Section~\ref{blah}
  
  function Complex#(cmplxd)  twiddle(Integer i);
     return cmplx(fromReal(cos(fromInteger(i)*pi/fromInteger(valueof(points)))),
                  fromReal(-1*sin(fromInteger(i)*pi/fromInteger(valueof(points)))));
  endfunction

  

  // In a perfect shuffle, an ordered list of elements is split in
  // half, and the two resulting lists are merged by interleaving the
  // elements.  This shuffle apears three times in the FFT shown in
  // Figure\~ref{blah}.
  
  function Vector#(points,Complex#(cmplxd)) perfectShuffle(Vector#(points,Complex#(cmplxd)) inVector);
    Vector#(points,Complex#(cmplxd)) outVector = newVector();
    for(Integer i = 0; i < valueof(points)/2; i=i+1)
      begin 
        outVector[i] =  inVector[i*2]; 
        outVector[i + valueof(points)/2 ] = inVector[i*2+1];
      end
    return outVector;
  endfunction
  
  // this function reorders the vector by swapping words at positions
  // corresponding to the bit-reversal of their indices.  This phase
  // of the Pease transform can be clearly seen in
  // Figire\~ref{blah}. The reordering can be done either as as the
  // first or last phase of the transformation.
  
  function Vector#(points,Complex#(cmplxd)) bitReverse(Vector#(points,Complex#(cmplxd)) inVector);
    Vector#(points,Complex#(cmplxd)) outVector = newVector();
    for(Integer i = 0; i < valueof(points); i = i+1)
      begin   
        Bit#(log_points) reversal = reverseBits(fromInteger(i));
        outVector[reversal] = inVector[i];           
      end  
    return outVector;
  endfunction

  // This function implements the butterfly networks, using the stage
  // variable to differentiate between the different phases of the FFT
  function Vector#(points,Complex#(cmplxd)) butterflyNetwork(Integer stage, Vector#(points,Complex#(cmplxd)) inVector);
    Vector#(points,Complex#(cmplxd)) outVector = newVector();
    for(Integer i = 0; i < valueof(points); i = i+2)
      begin    
        // As the stages progress, the roots of unity change.  They
        // are based on the top bits of the butterfly, Later stages
        // use "smaller" roots, i.e. 1st stage uses 1, 2nd stage uses
        // -j, etc.
        Complex#(cmplxd) multiplicand = inVector[i+1] * twiddle((i/exp(2,valueof(log_points)-stage)) * 
								exp(2,valueof(log_points)-stage));
        outVector[i] = inVector[i] + multiplicand;
        outVector[i+1] = inVector[i] - multiplicand;
      end 
    return outVector;
  endfunction

  // An N point FFT requires log(N) stages.  The numeric type
  // log_point was introduced in the provisos and is used as a loop
  // bound.  We use a different function at each stage of the FFT, and
  // use i to select this function in the butterflyNetwork.  There
  // rule creates one gigantic combinational circuit.

  rule fft;
    inputFIFO.deq();
    Vector#(points,Complex#(cmplxd)) outputdata = bitReverse(inputFIFO.first());
    for(Integer i = 0; i < valueof(log_points); i=i+1) 
      begin
        outputdata = perfectShuffle(butterflyNetwork(i,outputdata));  
      end
     outputFIFO.enq(outputdata);
  endrule
 
  // Interface method used to input Data to the FFT module.  Examine
  // FFTPipeline.bsv to see how this interface method is used
  method Action fftInput(Vector#(points, Complex#(cmplxd)) inVector);
    inputFIFO.enq(inVector);
  endmethod
  
  
  // Interface method used to get the transformed data from the FFT
  // Module.  Examine FFTPipeline.bsv to see how this interface method
  // is used
  method ActionValue#(Vector#(points, Complex#(cmplxd))) fftOutput; 
    outputFIFO.deq;
    return outputFIFO.first; 
  endmethod

endmodule



