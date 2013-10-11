module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor edx,edx -> mov edx,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31d2"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["ba00000000"] if ins.eql? "31d2"; ins}
    end
  end
end
