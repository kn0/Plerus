module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Addition Mutation - push pop nop (joined)",
        scope: SINGLE_MUTAGEN,
        change: ASM_ADDITION,
        targets: nil,
        safe: true
      })
    end

    def mutate(instruction)
      # Create an array of possible nops
      nops = []
      nops << "5058" # push eax,pop eax
      nops << "5159" # push ecx,pop ecx
      nops << "525a" # push edx,pop edx
      nops << "535b" # push ebx,pop ebx
      nops << "545c" # push esp,pop esp
      nops << "555d" # push ebp,pop ebp
      nops << "565e" # push esi,pop esi
      nops << "575f" # push edi,pop edi

      # Randomly add one nop to the end of the instruction
      instruction << nops.sample

      # Return the instruction
      return instruction
    end
  end
end
