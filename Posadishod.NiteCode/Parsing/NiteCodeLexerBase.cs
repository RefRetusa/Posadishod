using Antlr4.Runtime;
using System.IO;

namespace Posadishod.NiteCode.Parsing;

public abstract class NiteCodeLexerBase : Lexer
{
	public NiteCodeLexerBase(ICharStream input, TextWriter output, TextWriter errorOutput) : base(input, output, errorOutput)
	{
	}
}
