#!/bin/bash

if [ "$1" == "publish" ]; then
    git add -u
    git commit -a --allow-empty-message -m ''
    git push
    echo "blog published"
else
    if [ "$1" == "test" ]; then
    	bundle exec jekyll serve
    else
    	if [ "$1" == "newdraft" ]; then 
    		if [ "$2" == "" ]; then
    			echo "No file name given for new draft"
    		else 
				if [ -f "drafts/$2.md" ]; then
    				echo "$2.md already exist"
    			else 
    				cat draft.md > drafts/$2.md
    				git add drafts/$2.md
    				echo "created new draft drafts/$2.md and added it to repo"
    			fi
    		fi
    	else
    		if [ "$1" == "post" ]; then
    			if [ "$2" == "" ]; then
    				echo "No draft name given for post"
    			else
    				if [ -f "drafts/$2.md" ]; then
    					CURRENT_DATE=`date +"%Y-%m-%d"`
    					POST_NAME="_posts/${CURRENT_DATE}-$2.html"
    					if [ -f ${POST_NAME} ]; then 
    						cat drafts/$2.md > ${POST_NAME}
                            echo "post created: ${POST_NAME}" 
    					else 
							cat drafts/$2.md > ${POST_NAME}
							echo "post created: ${POST_NAME}" 
                            git add ${POST_NAME}
						fi
    				else
    					echo "No draft named drafts/$2.md found"
    				fi
    			fi
    		else
    			echo "Unknown command $1"
    		fi
    	fi
    fi
fi