using Antlr4.Runtime;
using Posadishod.NiteCode.Parsing;
using System.IO;


namespace Posadishod.Program;

internal static class EntryPoint
{
	public static void Main(string[] args)
	{
		AntlrInputStream stream = new(File.ReadAllText("test.nite"));

		NiteCodeLexer lexer = new(stream);
		CommonTokenStream tokenStream = new CommonTokenStream(lexer);

		NiteCodeParser parser = new(tokenStream);
		NiteCodeParser.Compilation_unitContext u = parser.compilation_unit();

		NiteCodeParserBaseVisitor<object> visitor = new();
		visitor.Visit(u);
	}
}
