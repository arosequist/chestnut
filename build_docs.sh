early_exit() {
    echo "Your git repo isn't clean, refusing to continue"
    exit 1
}

git diff-index --quiet --cached HEAD && git diff-files --quiet || early_exit

cd doc/ && \
    echo "Installing gitbook" && \
    npm install && \
    echo "Building the book" && \
    node_modules/.bin/gitbook build && \
    rm -rf /tmp/_book && \
    mv _book /tmp && \
    cd .. && \
    echo "Overwriting gh-pages" &&\
    git co gh-pages && \
    rm -rf * && \
    cp -r /tmp/_book/* . && \
    git add -A && \
    git commit -m 'update docs' && \
    echo "Pushing to Github" && \
    git push origin gh-pages:gh-pages && \
    git co -
