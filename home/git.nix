{ lib, config, ... }: {
	options = {
		git.setCredentials = lib.mkEnableOption "username and email";
		git.addAliases = lib.mkEnableOption "useful git aliases";
	};

	config = lib.mkMerge [
		(lib.mkIf config.git.setCredentials {
		 programs.git = {
		 userName = "Leonie Ziechmann";
		 userEmail = "48921293+leonieziechmann@users.noreply.github.com";
		 };
		 })

		(lib.mkIf config.git.addAliases {
			home.shellAliases = {
				gaa = "git add .";
				gs = "git status";
				gc = "git commit";
				gca = "git add . && git commit";
			};

			programs.git.aliases = {
				graph = ''log --oneline --graph --decorate --all'';
			};
		})

		{
			programs.git.enable = true;

			git.setCredentials = lib.mkDefault true;
			git.addAliases = lib.mkDefault true;

			programs.git.extraConfig = {
				pull.rebase = true;
			};
		}
	];
}
