class HALs_money {
	class Init {
		file = "HALs\Addons\Money\Functions";
		class initModule {postInit = 1;};
	};
	class Functions {
		file = "HALs\Addons\Money\Functions\Server";
		class addFunds {};
		class getFunds {};
	};
};
