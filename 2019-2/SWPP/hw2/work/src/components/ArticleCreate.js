import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect, Switch, Link } from 'react-router-dom';

class ArticleCreate extends Component{
    state = {
        isPreview: false,
        isDone: false,
        article: {
            author: this.props.author,
            id: this.props.id,
            title: "",
            content: ""
        }
    }

    handleChangeTitle = (event) => {
        this.setState({
            ...this.state,
            article: {
                ...this.state.article,
                title: event.target.value
            }
        });
    }

    handleChangeContent = (event) => {
        this.setState({
            ...this.state,
            article: {
                ...this.state.article,
                content: event.target.value
            }
        });
    }

    handleBack = () => {
        this.props.onAbortedCreateArticle();
    }

    handleCreate = () => {
        this.setState({
            ...this.state,
            isDone: true
        });
        console.log("handleCreate called");
        console.log("isDone: " + this.state.isDone);
        this.props.onFinishedCreateArticle(this.state.article);
    }

    handlePreview = () => {
        if(!this.state.isPreview)
            this.setState({
                ...this.state,
                isPreview: true
            });
    }

    handleWrite = () => {
        if(this.state.isPreview)
            this.setState({
                ...this.state,
                isPreview: false
            });
    }

    handleLogOut = () => {
        this.props.onLogOut();
        this.props.onCreateArticle(false);
    }

    render(){
        let redirectionURL = "/articles/" + this.state.article.id;

        if(this.props.isCreatingArticle === false)
            return(<Redirect to="/articles" />);

        if(this.state.isDone === true){
            this.props.onAbortedCreateArticle();
            return(<Redirect to={redirectionURL} />);
        }

        if(this.props.isLoggedIn === false)
            return (<Redirect to="/login" />);

        if(this.state.isPreview)
            return(
                <div>
                    Article Preview
                    <div>
                        <h1 id="article-title">{this.state.article.title}</h1>
                        <p  id="article-content">{this.state.article.content}</p>
                        <p  id="article-author">Author: {this.state.article.author}</p>
                    </div>
                    <p>
                        <button
                            id="back-create-article-button"
                            onClick={this.handleBack}
                        >Back</button>
                        <button 
                            id="confirm-create-article-button"
                            onClick={this.handleCreate}
                        >Confirm</button>
                        <button
                            id="preview-tab-button"
                            onClick={this.handlePreview}
                        >Preview</button>
                        <button
                            id="write-tab-button"
                            onClick={this.handleWrite}
                        >Continue writing</button>
                    </p>
                    <p>
                        <button
                            id="logout-botton"
                            onClick={this.handleLogOut}
                        >Log Out</button>
                    </p>
                </div>
            );

        return(
            <div>
                Article Create
                <div>
                    <textarea
                        id="article-title-input"
                        name="title"
                        placeholder="Your title of the article here"
                        onChange={this.handleChangeTitle}
                        value={this.state.article.title}
                    />
                </div>
                <p>
                    <textarea
                        id="article-content-input"
                        name="content"
                        placeholder="Your content of article here"
                        onChange={this.handleChangeContent}
                        value={this.state.article.content}
                    />
                </p>
                <p>
                    <button
                        id="back-create-article-button"
                        onClick={this.handleBack}
                    >Back</button>
                    <button 
                        id="confirm-create-article-button"
                        onClick={this.handleCreate}
                    >Confirm</button>
                    <button
                        id="preview-tab-button"
                        onClick={this.handlePreview}
                    >Preview</button>
                    <button
                        id="write-tab-button"
                        onClick={this.handleWrite}
                    >Continue writing</button>
                </p>

            </div>
        );
    }
}

export default ArticleCreate;