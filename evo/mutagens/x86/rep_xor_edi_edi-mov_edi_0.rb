module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor edi,edi -> mov edi,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31ff"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["bf00000000"] if ins.eql? "31ff"; ins}
      return gene
    end
  end
end
