public with sharing class RunningContext {

    public class RunningContextException extends Exception {}

    public Map<String, Object> variableMap = new Map<String, Object>();

    public RunningContext() {

    }

    public Object evalExpression(peterCompi.Expression exp) {
        return exp.eval(this);
    }

    public void setVarValue(String name, Object value) {
        this.variableMap.put(name, value);
    }

    public Object getVarValue(String varName) {

        if (!this.variableMap.containsKey(varName)) {
            throw new RunningContextException('No variable defined : ' + varName);
        }

        return this.variableMap.get(varName);
    }
}