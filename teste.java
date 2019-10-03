import java.io.FileReader;
import java.nio.file.Paths;

public class Main {

    public static void main(String[] args) {
        try {
            Parser p = new Parser(new LexicalAnalyzer(new FileReader("Program.pg")));
            Object result = p.parse().value;

            System.out.println("Compilacao concluida com sucesso...");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
