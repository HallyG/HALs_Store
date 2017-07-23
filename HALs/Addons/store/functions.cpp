class HALs_store {
	class Init {
		file = "HALs\Addons\Store\Functions";
		class initModule {postInit = 1;};
	};
	class System {
		file = "HALs\Addons\Store\Functions\System";
		class addItemCargo {};
		class canAddItem {};
		class canEquipItem {};
		class equipItem {};
		class getItemMass {};
		class getTraderStock {};
		class setTraderStock {};					
	};
	class Client {
		file = "HALs\Addons\Store\Functions\Client";
		class addAction {};
		class blur {};	
		class main {};
		class systemChat {};
		class update {};	
	};
	class Server {
		file = "HALs\Addons\Store\Functions\Server";
		class addTrader {};
		class purchase {};	
		class updateStock {};	
	};
}; 