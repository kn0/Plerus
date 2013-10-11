module Plerus
  class Evo < Mutagen
    def initialize
      super({
        title: "Replace Mutation - xor esi,esi -> mov esi,0",
        scope: SINGLE_MUTAGEN,
        change: ASM_REPLACE,
        targets: ["31f6"],
        safe: true
      })
    end

    def mutate(gene)
      # Check each instruction and if it matches XOR eax,eax, replace it with move 0,eax
      gene.map! {|ins| ins = ["be00000000"] if ins.eql? "31f6"; ins}
    end
  end
end
