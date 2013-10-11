==
Plerus is released under a BSD-2-clause license. See LICENSE for details.

The public GitHub source repository can be found at:
https://github.com/kn0/plerus

If you want to help out or have ideas you are willing to contribute, just email:
Trenton.Ivey(at)gmail.com

Intro
--
Plerus is a (very rudimentary) attempt to evolve shellcode using genetric algorithms. Be warned, it doesn't work very well yet.

The first attempt to create Plerus made use of metasm to disassemble raw machine code.
Unfortunatly, metasm didn't always reliably disassemble much of the shellcode provided by metasploit (This could just be user error) without some amount of manual help.

The second attempt (what is included here) makes use of a .yaml configuration file that represents the shellcode (see sample/exec\_calc.yaml). This file represents an array within an array.
The inner arrays each represent one "gene" or function, while each member of the array represents individaul machine code representations. This was intended to help in the crossover phase of genetic evolution.
 
This version does a great job of evolving shellcode if it does not make use of relative addresses in JMPs or CALLs (unfortunately these are very common instructions in most shellcode).

Instead of continuing to work with machine code representations, future attempts are going to return to the disassemble/evolve/re-compile method, but other disassembly methods are being considered.
There is even some talk of moving everyhing from Ruby to Python.

i686-w64-mingw32-gcc is used to compile code. Make sure it is installed prior to running example.rb

Further Information
--
 * The original presentation discussion this code and concept can be found on [youtube][original_talk]
 * The slide deck used in the presentation can be found on [Prezi][original_presentation]


[original_talk]: https://www.youtube.com/watch?v=NTnarZI3aME
[original_presentation]: http://prezi.com/xec2akdxz_1c/antivirus-evasion-through-antigenic-variation/ "Antivirus Evasion Through Antigenic Variation"


