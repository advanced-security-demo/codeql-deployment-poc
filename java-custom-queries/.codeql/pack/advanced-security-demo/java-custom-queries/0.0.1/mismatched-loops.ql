import java

predicate isInc(UnaryAssignExpr expr) {
  expr instanceof PreIncExpr or
  expr instanceof PostIncExpr
}

from ForStmt for, ComparisonExpr comparison, UnaryAssignExpr update, Variable v
where
  comparison = for.getCondition() and
  update = for.getAnUpdate() and
  update.getExpr() = v.getAnAccess() and
  (
    comparison.getGreaterOperand() = v.getAnAccess() and
    isInc(update)
    or
    comparison.getLesserOperand() = v.getAnAccess() and
    not isInc(update)
  )
select for, comparison, update, v
