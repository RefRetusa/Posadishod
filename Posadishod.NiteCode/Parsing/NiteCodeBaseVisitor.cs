using Antlr4.Runtime.Misc;

namespace Posadishod.NiteCode.Parsing;

public class NiteCodeBaseVisitor : NiteCodeParserBaseVisitor<object>
{
    public override object VisitCompilation_unit([NotNull] NiteCodeParser.Compilation_unitContext context)
    {
        return base.VisitCompilation_unit(context);
    }
    public override object VisitNamespace_unit([NotNull] NiteCodeParser.Namespace_unitContext context)
    {
        System.Console.WriteLine(context.children[context.ChildCount-2].GetText());

        return base.VisitNamespace_unit(context);
    }
}
