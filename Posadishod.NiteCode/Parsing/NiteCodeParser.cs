using Antlr4.Runtime;
using System.IO;

namespace Posadishod.NiteCode.Parsing;

public abstract class NiteCodeParserBase : Parser
{
	public NiteCodeParserBase(ITokenStream input, TextWriter output, TextWriter errorOutput) : base(input, output, errorOutput)
	{
	}
}
