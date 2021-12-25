package malten;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import mal.env.Env;
import mal.stepA_mal;
import mal.types;
import mal.types.MalException;
import mal.types.MalString;
import mal.types.MalInteger;
import mal.types.MalSymbol;
import mal.types.MalThrowable;
import mal.types.MalList;
import mal.types.MalVal;
import mal.types.MalHashMap;
import util.Utils;

public class Malten {

    public static String render(Context context, String template) {
        return new Malten()._render(context, template);
    }

    private String _render(Context context, String template) {
        String renderer = genRenderer(template);
        Utils.putskv_e("renderer", renderer);
        return doRender(context, renderer);
    }

    private String genRenderer(String template) {
        Env env = new Env(null);
        
        env.set(new MalSymbol("template"), new MalString(template));

        MalVal malVal = readEval(env, "(gen-renderer template)");

        if (! (malVal instanceof MalString)) {
            throw new RuntimeException("MalString is expected");
        }

        return ((MalString)malVal).getValue();
    }

    private String doRender(Context context, String renderer) {
        Env env = toEnv(context);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PrintStream originalStdout = System.out;

        System.setOut(
                    new PrintStream(
                            new BufferedOutputStream(baos)
                    )
        );

        readEval(env, renderer);

        System.out.flush();
        String output = baos.toString();

        System.setOut(originalStdout);

        return output;
    }

    private MalVal readEval(Env env, String malSrc) {
        String malCode = String.format(
                "(do "
                + " (load-file \"../malten.mal\") "
                + "  %s"
                + ")",
                malSrc
        );

        try {
            return stepA_mal.readEval(env, malCode);
        } catch (MalException e) {
            e.printStackTrace();
            Utils.puts_e(e.getValue());
            throw new RuntimeException(e);
        } catch (MalThrowable e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private Env toEnv(Context context) {
        Env env = new Env(null);

        for (String k : context.map.keySet()) {
            MalVal malVal = toMalVal(context.map.get(k));
            env.set(new MalSymbol(k), malVal);
        }
        
        return env;
    }

    private MalVal toMalVal(Object obj) {
        if (obj == null) {
            return types.Nil;
        } else if (obj instanceof String) {
            return new MalString((String)obj);
        } else if (obj instanceof Integer) {
            return new MalInteger((Integer)obj);
        } else if (obj instanceof List) {
            List<Object> xs = (List<Object>)obj;
            return new MalList(
                xs.stream()
                // .map(x -> toMalVal(x))
                .map(this::toMalVal)
                .collect(Collectors.toList())
            );
        } else if (obj instanceof Map) {
            Map<String, Object> map = (Map<String, Object>)obj;
            Map<String, MalVal> newMap = new HashMap<>();
            for (String key : map.keySet()) {
                newMap.put(key, toMalVal(map.get(key)));
            }
            return new MalHashMap(newMap);
        } else {
            throw new RuntimeException("not yet supported: " + obj.getClass().getName());
        }
    }

}
