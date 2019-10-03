import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

class Login extends Component{
    state = {
        email: "",
        password: "",
    }

    handleChange = (event) => {
        this.setState({
            [event.target.name]: event.target.value 
        });
    }

    handleSubmit = (event) => {
        event.preventDefault();
        if((this.state.email !== "swpp@snu.ac.kr") || (this.state.password !== "iluvswpp")){
            alert("Email or password is wrong");
            this.setState({
                ...this.state,
                password: ""
            });
        }
        else{
            this.props.onLogIn(this.state);
        }
    }

    render(){
        let redirectToArticles = this.props.isLoggedIn ? <Redirect to="/articles" /> : null;

        return(
            <form onSubmit={this.handleSubmit}>
                <div>
                    <input
                        id="email-input"
                        name="email"
                        placeholder="Your e-mail here"
                        onChange={this.handleChange}
                        value={this.state.email}
                    />
                </div>
                <div>
                    <input
                        id="pw-input"
                        name="password"
                        placeholder="Your password here"
                        onChange={this.handleChange}
                        value={this.state.password}
                    />
                </div>
                <button
                    id="login-button"
                    type="submit"
                >Submit</button>
                {redirectToArticles}
            </form>
        );
    }
}

export default Login;