class K {
  const K._();

  static const userKey = 'CURRENT_USER';

  static const regexEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const regexURL =
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";

  static const signInImage = 'assets/images/undraw_authentication_re_svpt.svg';

  static const signUpImage = 'assets/images/undraw_profile_details_re_ch9r.svg';
}
