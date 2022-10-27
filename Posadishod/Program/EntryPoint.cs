using Antlr4.Runtime;
using Posadishod.Core;
using Posadishod.NiteCode.Parsing;
using NiTiS.IO;


namespace Posadishod.Program;

internal class EntryPoint : App
{

	public static void Main(string[] args)
	{
        System.Console.WriteLine("Arguments: ");
        foreach (string arg in args)
        {
            System.Console.WriteLine(arg);
        }

        new EntryPoint();
	}
	private EntryPoint()
	{
        AntlrInputStream stream = new(new File("test.nite").ReadAllText());

        NiteCodeLexer lexer = new(stream);
        CommonTokenStream tokenStream = new CommonTokenStream(lexer);

        NiteCodeParser parser = new(tokenStream);
        NiteCodeParser.Compilation_unitContext u = parser.compilation_unit();

        NiteCodeParserBaseVisitor<object> visitor = new();
        visitor.Visit(u);
    }
}
