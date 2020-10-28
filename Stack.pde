class Stack {
  ArrayList<GameObject> items;

  public Stack() {
    items = new ArrayList<GameObject>();
  }

  public void push(GameObject item) {
    items.add(item);
  }

  public GameObject pop() {
    GameObject item = items.get(items.size() - 1);
    items.remove(items.size() - 1);
    return item;
  }

  public GameObject peek() {
    return items.get(items.size() - 1);
  }

  public boolean isEmpty() {
    return items.size() == 0;
  }
}
