module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor ecx,ecx -> mov ecx,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31c9"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["b900000000"] if ins.eql? "31c9"; ins}
    end
  end
end
