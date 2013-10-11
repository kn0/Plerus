module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor eax,eax -> mov eax,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31c0"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["b800000000"] if ins.eql? "31c0"; ins}
    end
  end
end
