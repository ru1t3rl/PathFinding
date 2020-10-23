class Stack {
  ArrayList<GameObject> items;

  public Stack() {
    items = new ArrayList<GameObject>();
  }

  public void Push(GameObject item) {
    items.add(item);
  }

  public GameObject Pop() {
    GameObject item = items.get(items.size() - 1);
    items.remove(items.size() - 1);
    return item;
  }

  public GameObject Peek() {
    return items.get(items.size() - 1);
  }

  public boolean Empty() {
    return (items.size() == 0) ? true : false;
  }
}
