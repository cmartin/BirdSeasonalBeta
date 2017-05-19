all:
	rm BirdSeasonBeta.zip
	zip -r BirdSeasonBeta.zip . -x "./cache/*" "./ms/*" "./wc10/*" "./submissions/*" "*.DS_Store" "./.Rproj.user/*" ".Rhistory" "./.git/*"
