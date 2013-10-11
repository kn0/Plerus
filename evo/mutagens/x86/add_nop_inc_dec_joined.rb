module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Addition Mutation - inc/dec register nop joined",
        scope: SINGLE_MUTAGEN,
        change: ASM_ADDITION,
        targets: nil,
        safe: true
      })
    end

    def mutate(instruction)
      # Create an array of possible nops
      nops = []
      nops << "4048" # inc eax, dec eax
      nops << "4149" # inc ecx, dec ecx
      nops << "424a" # inc edx, dec edx
      nops << "434b" # inc ebx, dec ebx
      nops << "444c" # inc esp, dec esp
      nops << "454d" # inc ebp, dec ebp
      nops << "464e" # inc esi, dec esi
      nops << "474f" # inc edi, dec edi

      # Randomly add one nop to the end of the instruction
      instruction << nops.sample

      # Return the Instruction
      return instruction
    end
  end
end
