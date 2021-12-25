package malten.sample;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import malten.Context;
import malten.Malten;
import util.Utils;

public class Sample {

    public void run() {
        String template = getTemplate();

        Context context = new Context();
    
        context.map.put("date", "2021-12-25");
        
        {
            List<Map<String, Object>> items = new ArrayList<>();
            items.add(new Item(1, "foo", 100, null).toPlain());
            items.add(new Item(2, "bar", 200, null).toPlain());
            items.add(new Item(3, "baz", 300,   50).toPlain());
            context.map.put("items", items);
        }

        String rendered = Malten.render(context, template);
        System.out.println(rendered);
    }

//  String getTemplate() {
//  String templatePath = System.getenv("TEMPLATE");
//
//  if (templatePath == null) {
//      return "Use the environment variable TEMPLATE to specify the path of the template file.";
//  }
//
//  return Utils.readFile(templatePath);
//}

    String getTemplate() {
        return lines(
              "日付: <%= date %>\n"
            , "<table>"
            , "  <tr><th>ID</th><th>品名</th><th>価格</th></tr>"
            , "  <% (map (fn* [item] (do %> "
            , "  <tr> "
            , "    <td><%= (get item \"id\") %></td> "
            , "    <td><%= (get item \"name\") %></td> "
            , "    <td><%= (- (get item \"price\")"
            , "               (if (get item \"discount\")"
            , "                 (get item \"discount\")"
            , "                 0))"
            , "        %> 円</td>"
            , "  </tr> "
            , "  <% )) items) %> "
            , "</table>"
        );
    }

    String lines(String ...lines ) {
        return Arrays.stream(lines)
                .map(line -> line + Utils.LF)
                .collect(Collectors.joining())
                ;
    }

}
