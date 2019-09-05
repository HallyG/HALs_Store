class HALs_store {
	class Init {
		file = "HALs\Addons\store\functions";
		class initModule {postInit = 1;};
	};

	class System {
		file = "HALs\Addons\store\functions\system";
		class addItemCargo {};
		class canAddItem {};
		class canEquipItem {};
		class equipItem {};
		class getItemMass {};
		class getItemStats {};
		class getItemType {};
	};

	class Client {
		file = "HALs\Addons\store\functions\client";
		class addAction {};
		class main {};
		class systemChat {};
		class update {};
	};

	class Server {
		file = "HALs\Addons\store\functions\server";
		class addTrader {};
		class getTraderStock {};
		class purchase {};
		class setTraderStock {};
		class updateStock {};
	};

	class Misc {
		file = "HALs\Addons\store\functions\misc";
		class addMoneyOnOpen {};
	};
};
