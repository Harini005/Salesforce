public class Stack {
    
    List<Object> objList = new List<Object>();
    public void push(Object obj) {
        //implement push
        objList.add(obj);
    }
    
    public Object pop() {
        //implement pop
        Integer listSize = objList.size();
        Integer arraySize = listSize == 1 ? 0 : listSize-1;
        return listSize == 0 ? null :objList.remove(arraySize);
    }
    
    public Integer size() {
        //implement size
        return objList.size();
    }
    
    public Object peek(){
        //implement peek
        return objList[objList.size()-1];
    }
    
    public Boolean isEmpty() {
        //implement isEmpty
        return objList.isEmpty();
    }
}