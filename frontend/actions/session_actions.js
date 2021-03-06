import * as APIUtil from '../util/sessions_api_util';

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
export const RECEIVE_ERRORS = "RECEIVE_ERRORS";
export const CLEAR_ERRORS = "CLEAR_ERRORS";

export const clearErrors = () => ({
  type: CLEAR_ERRORS
});

export const receiveCurrentUser = currentUser => ({
  type: RECEIVE_CURRENT_USER,
  currentUser
});

export const receiveErrors = errors => ({
  type: RECEIVE_ERRORS,
  errors
});

export const signup = user => dispatch => (
  APIUtil.signup(user)
  .then(data => (dispatch(receiveCurrentUser(data))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ))
);

export const logout = () => dispatch => (
  APIUtil.logout()
    .then(() => dispatch(receiveCurrentUser(null)))
);

export const login = user => dispatch => (
  APIUtil.login(user)
    .then(data => (dispatch(receiveCurrentUser(data))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ))
);
