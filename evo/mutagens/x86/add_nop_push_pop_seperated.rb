module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Addition Mutation - push pop nop (separated)",
        scope: SINGLE_MUTAGEN,
        change: ASM_ADDITION,
        targets: nil,
        safe: false
      })
    end

    def mutate(instruction)
      # Create an array of possible nops
      nops = []
      nops << ["50","58"] # push eax,pop eax
      nops << ["51","59"] # push ecx,pop ecx
      nops << ["52","5a"] # push edx,pop edx
      nops << ["53","5b"] # push ebx,pop ebx
      nops << ["54","5c"] # push esp,pop esp
      nops << ["55","5d"] # push ebp,pop ebp
      nops << ["56","5e"] # push esi,pop esi
      nops << ["57","5f"] # push edi,pop edi

      # Randomly choose one nop
      nop =  nops.sample
      # Add the push at the begining of the instruction
      instruction.unshift nop[0]
      # Add the pop at the end of the instruction
      instruction.push nop[1]
      # Return the modified instruction
      return instruction
    end
  end
end
