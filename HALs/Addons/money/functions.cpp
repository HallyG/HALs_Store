class HALs_money {
	class Init {
		file = "HALs\Addons\money\functions";
		class initModule {postInit = 1;};
	};
	
	class Client {
		file = "HALs\Addons\money\functions\client";
		class initClient {};
	};
	
	class Server {
		file = "HALs\Addons\money\functions\server";
		class addFunds {};
		class getFunds {};
		class initServer {};
	};
};
