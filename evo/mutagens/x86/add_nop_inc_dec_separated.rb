module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Addition Mutation - inc/dec register nop separated",
        scope: SINGLE_MUTAGEN,
        change: ASM_ADDITION,
        targets: nil,
        safe: false
      })
    end

    def mutate(instruction)
      # Create an array of possible nops
      nops = []
      nops << ["40","48"] # inc eax, dec eax
      nops << ["41","49"] # inc ecx, dec ecx
      nops << ["42","4a"] # inc edx, dec edx
      nops << ["43","4b"] # inc ebx, dec ebx
      nops << ["44","4c"] # inc esp, dec esp
      nops << ["45","4d"] # inc ebp, dec ebp
      nops << ["46","4e"] # inc esi, dec esi
      nops << ["47","4f"] # inc edi, dec edi

      # Randomly choose one nop
      nop = nops.sample
      # Add the inc at the begining of the instruction
      instruction.unshift nop[0]
      # Add the dec at the end of the instruction
      instruction.push nop[1]
      # Return the Instruction
      return instruction
    end
  end
end
