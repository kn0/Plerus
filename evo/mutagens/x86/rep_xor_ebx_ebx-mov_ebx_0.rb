module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor ebx,ebx -> mov ebx,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31db"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["bb00000000"] if ins.eql? "31db"; ins}
    end
  end
end
