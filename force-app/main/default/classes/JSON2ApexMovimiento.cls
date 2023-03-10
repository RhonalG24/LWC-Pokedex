//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class JSON2ApexMovimiento {

	public class Damage_class {
		public String name {get;set;} 
		public String url {get;set;} 

		public Damage_class(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'url') {
							url = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Damage_class consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Integer accuracy {get;set;} 
	public Damage_class damage_class {get;set;} 
	public Integer effect_chance {get;set;} 
	public List<Effect_entries> effect_entries {get;set;} 
	public Integer id {get;set;} 
	public String name {get;set;} 
	public Integer power {get;set;} 
	public Integer pp {get;set;} 
	public Integer priority {get;set;} 
	public Damage_class target {get;set;} 
	public Damage_class type {get;set;} 

	public JSON2ApexMovimiento(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'accuracy') {
						accuracy = parser.getIntegerValue();
					} else if (text == 'damage_class') {
						damage_class = new Damage_class(parser);
					} else if (text == 'effect_chance') {
						effect_chance = parser.getIntegerValue();
					} else if (text == 'effect_entries') {
						effect_entries = arrayOfEffect_entries(parser);
					} else if (text == 'id') {
						id = parser.getIntegerValue();
					} else if (text == 'name') {
						name = parser.getText();
					} else if (text == 'power') {
						power = parser.getIntegerValue();
					} else if (text == 'pp') {
						pp = parser.getIntegerValue();
					} else if (text == 'priority') {
						priority = parser.getIntegerValue();
					} else if (text == 'target') {
						target = new Damage_class(parser);
					} else if (text == 'type') {
						type = new Damage_class(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2ApexMovimiento consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Effect_entries {
		public String effect {get;set;} 
		public Damage_class language {get;set;} 
		public String short_effect {get;set;} 

		public Effect_entries(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'effect') {
							effect = parser.getText();
						} else if (text == 'language') {
							language = new Damage_class(parser);
						} else if (text == 'short_effect') {
							short_effect = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Effect_entries consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2ApexMovimiento parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2ApexMovimiento(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	



    private static List<Effect_entries> arrayOfEffect_entries(System.JSONParser p) {
        List<Effect_entries> res = new List<Effect_entries>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Effect_entries(p));
        }
        return res;
    }




}