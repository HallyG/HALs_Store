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
		class getCargoMass {};
		class getCompatibleItems {};
		class getItemMass {};
		class getItemStats {};
		class getItemType {};
	};

	class Client {
		file = "HALs\Addons\store\functions\client";
		class addAction {};
		class systemChat {};
	};

	class Server {
		file = "HALs\Addons\store\functions\server";
		class addTrader {};
		class purchase {};
	};

	class Stock {
		file = "HALs\Addons\store\functions\server\stock";
		class getTraderStock {};
		class setTraderStock {};
		class updateStock {};
	};

	class UI {
		file = "HALs\Addons\store\functions\client\ui";
		class main {};
		class update {};
	};
};
