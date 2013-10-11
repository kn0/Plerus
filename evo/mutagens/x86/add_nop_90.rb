module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Addition Mutation - x90 NOP",
        scope: SINGLE_MUTAGEN,
        change: ASM_ADDITION,
        targets: nil,
        safe: true
      })
    end

    def mutate(instruction)
      instruction << "90"
      return instruction
    end
  end
end
