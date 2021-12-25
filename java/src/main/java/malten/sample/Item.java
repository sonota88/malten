package malten.sample;

import java.util.HashMap;
import java.util.Map;

public class Item {

    public int id;
    public String name;
    public int price;
    public Integer discount;

    public Item(int id, String name, int price, Integer discount) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discount = discount;
    }

    public Map<String, Object> toPlain() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("price", price);
        map.put("discount", discount);
        return map;
    }

}
