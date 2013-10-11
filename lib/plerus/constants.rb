module Plerus
  # EVO Types

  EVO_MUTAGEN              = "Plerus Mutagen Evo Module"
  EVO_COMPILER             = "Plerus Compiler Evo Module"

  # Mutagen Change Types

  ASM_ADDITION             = (1<<0) # 1
  ASM_SUBTRACTION          = (1<<1) # 2
  ASM_REPLACE              = (1<<2) # 4
  SINGLE_MUTAGEN           = (1<<3) # 8
  MULTI_MUTAGEN            = (1<<4) # 16

  # Default Settings:

  DEFAULT_POOL_SIZE                    = 1_000
  DEFAULT_MAX_MUTATIONS_PER_GENERATION = 10
  DEFAULT_MIN_MUTATIONS_PER_GENERATION = 1
end
