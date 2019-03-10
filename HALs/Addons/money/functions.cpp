class HALs_money {
	class Init {
		file = "HALs\Addons\money\functions";
		class initModule {postInit = 1;};
	};
	
	class Functions {
		file = "HALs\Addons\money\functions\server";
		class addFunds {};
		class getFunds {};
	};
};
