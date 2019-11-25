import java.io.*;

public class Main {
    static LexicalAnalyzer lexicalAnalyzer;

    public static void main(String[] args) {
        try {
            lexicalAnalyzer = new LexicalAnalyzer(new FileReader("Program.pg"));
            Parser p = new Parser(lexicalAnalyzer);
            p.parse();
            if (Parser.errors == 0) {
                try {
                    PrintWriter file;
                    file = new PrintWriter(new FileOutputStream("output.s"));
                    file.println(Parser.code);
                    file.flush();
                    file.close();
                    System.out.println("Sucesso.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else
               System.out.println("Nenhum código intermediário produzido. Erros encontrados");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
