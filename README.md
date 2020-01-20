###Command line instructions
You can also upload existing files from your computer using the instructions below.


###Git global setup
```
git config --global user.name "Tashi Dendup"
git config --global user.email "tashi.dendup@dcpl.bt"
```

###Create a new repository
```
git clone git@gitlab.dcpl.bt:dcpl/paysap-api.git
cd paysap-api
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

###Push an existing folder
```
cd existing_folder
git init
git remote add origin git@gitlab.dcpl.bt:dcpl/paysap-api.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

###Push an existing Git repository
```
cd existing_repo
git remote rename origin old-origin
git remote add origin git@gitlab.dcpl.bt:dcpl/paysap-api.git
git push -u origin --all
git push -u origin --tags
```
